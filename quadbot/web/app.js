'use strict';
/* quadbot bench console. Plain JavaScript, no external requests, so it works on a Pi hotspot with no internet. */

const $ = (s, el = document) => el.querySelector(s);
const $$ = (s, el = document) => [...el.querySelectorAll(s)];
const LEGS = ['FL', 'FR', 'RL', 'RR'];
const JOINTS = ['coxa', 'femur', 'tibia'];
const LEG_NAME = { FL: 'Front left', FR: 'Front right', RL: 'Rear left', RR: 'Rear right' };
const MODEL_COLOR = { MG958: '#e8891d', MG996R: '#d6453d', MG995: '#2e9b4b' };

let ws = null, cal = null, st = null, scan = null;
let selLeg = 'FL', legTestLeg = 'FL', tab = 'drive', target = null, rangeM = 3;
let noticeText = '', noticeTimer = null;

/* ------------------------------------------------------------------ socket */
function send(o) { if (ws && ws.readyState === 1) ws.send(JSON.stringify(o)); }
const lastSent = {};
function sendThrottled(key, o, ms = 40) {
  const now = performance.now();
  if (!lastSent[key] || now - lastSent[key] > ms) { lastSent[key] = now; send(o); }
}

function connect() {
  const proto = location.protocol === 'https:' ? 'wss' : 'ws';
  ws = new WebSocket(`${proto}://${location.host}/ws`);
  ws.onopen = () => $('#conn').classList.add('live');
  ws.onclose = () => { $('#conn').classList.remove('live'); setTimeout(connect, 1000); };
  ws.onmessage = (e) => {
    const m = JSON.parse(e.data);
    if (m.t === 'cal') onCal(m);
    else if (m.t === 'state') onState(m);
    else if (m.t === 'scan') { scan = m; if (tab === 'radar') drawRadar(); }
  };
}

/* ------------------------------------------------------------------ kinematics (mirror of the Python, for display) */
function fk(g, th1, a, b) {
  const gam = a - Math.PI / 2 + b;
  const r = g.coxa + g.femur * Math.cos(a) + g.tibia * Math.cos(gam);
  return [r * Math.cos(th1), r * Math.sin(th1), g.femur * Math.sin(a) + g.tibia * Math.sin(gam)];
}
function ik(g, x, y, z) {
  const th1 = Math.atan2(y, x), r = Math.hypot(x, y) - g.coxa, d = Math.hypot(r, z);
  const lo = Math.abs(g.femur - g.tibia) + 1e-3, hi = g.femur + g.tibia - 1e-3;
  const ok = d >= lo && d <= hi, dc = Math.min(Math.max(d, lo), hi);
  const cl = (v) => Math.max(-1, Math.min(1, v));
  const eps = Math.acos(cl((g.femur ** 2 + dc ** 2 - g.tibia ** 2) / (2 * g.femur * dc)));
  const kap = Math.acos(cl((g.femur ** 2 + g.tibia ** 2 - dc ** 2) / (2 * g.femur * g.tibia)));
  return { th1, a: Math.atan2(z, r) + eps, b: kap - Math.PI / 2, ok };
}
const rad = (d) => d * Math.PI / 180, deg = (r) => r * 180 / Math.PI;

/* ------------------------------------------------------------------ incoming */
function onCal(m) {
  cal = m;
  buildGaitSliders(); buildAvoidSliders(); buildSatGrid(); buildCards(); buildLegSliders();
  $('#chkAvoid').checked = m.avoid.enabled;
}

function onState(m) {
  st = m;
  if (cal && m.cal_version !== cal.version) send({ t: 'get_cal' });

  $('#arm').setAttribute('aria-pressed', String(m.armed));
  $('#arm').textContent = m.armed ? 'Armed' : 'Arm servos';
  const chip = $('#modeChip'); chip.textContent = m.estop ? 'e-stopped' : m.mode;
  $$('#modeSeg button').forEach((b) => b.classList.toggle('on', b.dataset.mode === m.mode));

  if (m.notice && m.notice !== noticeText) showNotice(m.notice, m.estop);
  noticeText = m.notice;

  const enList = m.enabled_list || Object.keys(m.live || {}).filter(k => m.live[k].en);
  const numEn = m.num_enabled != null ? m.num_enabled : enList.length;
  const totalS = m.total_servos || 12;
  const sBadge = $('#servoBadge');
  if (sBadge) {
    sBadge.textContent = `${numEn}/${totalS} servos`;
    sBadge.classList.toggle('live', numEn > 0);
    sBadge.classList.toggle('all-on', numEn === totalS);
  }
  const sCount = $('#servoCountDrive');
  if (sCount) {
    sCount.textContent = `${numEn} / ${totalS} active`;
    sCount.classList.toggle('all-on', numEn === totalS);
  }

  const sNotice = $('#scopeNotice');
  if (sNotice) {
    if (numEn === 0) sNotice.textContent = 'None active (limp)';
    else if (numEn === 1) sNotice.textContent = `1 servo (${enList[0]})`;
    else if (numEn === 3) {
      const leg = ['FL', 'FR', 'RL', 'RR'].find(l => ['coxa', 'femur', 'tibia'].every(j => enList.includes(`${l}_${j}`)));
      sNotice.textContent = leg ? `Leg ${leg} active (3 servos)` : `${numEn} servos active`;
    } else if (numEn === 6) {
      const isLeft = enList.every(id => id.startsWith('FL') || id.startsWith('RL'));
      const isRight = enList.every(id => id.startsWith('FR') || id.startsWith('RR'));
      sNotice.textContent = isLeft ? 'Left board active (6)' : isRight ? 'Right board active (6)' : '6 servos active';
    } else if (numEn === 12) {
      sNotice.textContent = 'All 12 servos active';
    } else {
      sNotice.textContent = `${numEn} active`;
    }
  }

  $$('#scopeSeg button').forEach((b) => {
    const sc = b.dataset.scope;
    let on = false;
    if (sc === 'all') on = numEn === 12;
    else if (['FL', 'FR', 'RL', 'RR'].includes(sc)) on = numEn === 3 && ['coxa', 'femur', 'tibia'].every(j => enList.includes(`${sc}_${j}`));
    else if (sc === 'left') on = numEn === 6 && enList.every(id => id.startsWith('FL') || id.startsWith('RL'));
    else if (sc === 'right') on = numEn === 6 && enList.every(id => id.startsWith('FR') || id.startsWith('RR'));
    b.classList.toggle('on', on);
  });

  $('#chkDerate').checked = m.auto_derate;
  $('#derateBar').style.width = Math.round(m.gait_scale * 100) + '%';
  $('#derateVal').textContent = Math.round(m.gait_scale * 100) + '%';
  const a = m.avoid, ac = $('#avoidChip');
  ac.textContent = a.state === 'off' ? 'off' : a.front_mm != null && isFinite(a.front_mm) ? `${a.state} · ${(a.front_mm / 1000).toFixed(2)} m` : a.state;
  ac.style.color = { blocked: 'var(--stop)', lidar_lost: 'var(--stop)', slow: '#a86f00', clear: 'var(--ok)' }[a.state] || '';
  updateSat(); updateCalLive(); updateLegReadout();
  $('#legTestState').textContent = m.mode === 'legtest' ? 'running' : 'off';
  const mock = m.lidar === 'mock';
  $('#mockRow').hidden = !mock;
  $('#lidStatus').textContent = m.lidar;

  if (m.battery && m.battery.present) {
    const b = m.battery;
    const bBadge = $('#batteryBadge');
    if (bBadge) {
      bBadge.hidden = false;
      $('#batPct').textContent = `${Math.round(b.percent)}%`;
      $('#batVolt').textContent = `${b.voltage.toFixed(1)}V`;
      bBadge.classList.toggle('bat-ok', b.state === 'ok');
      bBadge.classList.toggle('bat-warn', b.state === 'low');
      bBadge.classList.toggle('bat-crit', b.state === 'critical');
      bBadge.title = `2S LiPo: ${b.voltage.toFixed(2)}V (${Math.round(b.percent)}%) - ${b.state}`;
    }
  }

  if (tab === 'calib') drawChassis();
}

function showNotice(text, bad) {
  const n = $('#notice');
  n.textContent = text; n.hidden = false; n.classList.toggle('bad', !!bad);
  clearTimeout(noticeTimer); noticeTimer = setTimeout(() => { n.hidden = true; }, 7000);
}

/* ------------------------------------------------------------------ small ui helpers */
function mkSlider(host, o) {
  const wrap = document.createElement('label'); wrap.className = 'slide';
  const fmt = (v) => `${(+v).toFixed(o.dec ?? (o.step < 1 ? 2 : 0))} ${o.unit || ''}`;
  wrap.innerHTML = `<span>${o.label}<b></b></span><input type="range" min="${o.min}" max="${o.max}" step="${o.step}">`;
  const inp = $('input', wrap), out = $('b', wrap);
  inp.value = o.value; out.textContent = fmt(o.value);
  inp.addEventListener('input', () => { out.textContent = fmt(inp.value); o.onInput(+inp.value); });
  host.appendChild(wrap);
  return { inp, out, fmt };
}

/* ------------------------------------------------------------------ drive tab */
function buildGaitSliders() {
  const host = $('#gaitSliders'); host.innerHTML = '';
  const g = cal.gait;
  [
    ['speed_scale', 'Speed scale', 0.2, 1.5, 0.05, '×'],
    ['step_len', 'Step length', 10, 70, 1, 'mm'],
    ['step_height', 'Step height', 10, 50, 1, 'mm'],
    ['freq_hz', 'Step rate', 0.2, 2.0, 0.05, 'Hz'],
    ['height_stand', 'Body height', 50, 130, 1, 'mm'],
    ['yaw_step_deg', 'Turn per step', 5, 25, 1, '°'],
  ].forEach(([key, label, min, max, step, unit]) =>
    mkSlider(host, { label, min, max, step, unit, value: g[key], onInput: (v) => sendThrottled('p_' + key, { t: 'params', [key]: v }) }));
}

function buildSatGrid() {
  const host = $('#satGrid'); host.innerHTML = '';
  LEGS.forEach((leg) => {
    const d = document.createElement('div'); d.className = 'satleg';
    d.innerHTML = `<b>${leg}</b>` + JOINTS.map((j) => `<div class="sat"><span>${j.slice(0, 3)}</span><div><i id="sat-${leg}_${j}"></i></div></div>`).join('');
    host.appendChild(d);
  });
}
function updateSat() {
  if (!st) return;
  for (const [sid, v] of Object.entries(st.live)) {
    const el = document.getElementById('sat-' + sid); if (!el) continue;
    const val = Math.max(v.sat, v.clamp);
    el.style.width = Math.min(100, val * 100) + '%';
    el.classList.toggle('clamp', v.clamp > v.sat);
  }
}

// virtual sticks
function makeStick(el) {
  const knob = $('i', el), v = { x: 0, y: 0, active: false };
  const set = (e) => {
    const r = el.getBoundingClientRect(), R = r.width / 2;
    let dx = (e.clientX - (r.left + R)) / R, dy = (e.clientY - (r.top + R)) / R;
    const m = Math.hypot(dx, dy); if (m > 1) { dx /= m; dy /= m; }
    v.x = dx; v.y = -dy; knob.style.transform = `translate(${dx * R * 0.62}px, ${dy * R * 0.62}px)`;
  };
  const end = () => { v.active = false; v.x = 0; v.y = 0; knob.style.transform = ''; };
  el.addEventListener('pointerdown', (e) => { el.setPointerCapture(e.pointerId); v.active = true; set(e); });
  el.addEventListener('pointermove', (e) => { if (v.active) set(e); });
  el.addEventListener('pointerup', end); el.addEventListener('pointercancel', end);
  return v;
}
const stickMove = makeStick($('#stickMove')), stickTurn = makeStick($('#stickTurn'));

// keyboard
const keys = new Set();
addEventListener('keydown', (e) => {
  if (e.target.tagName === 'INPUT' && e.target.type !== 'range') return;
  if (e.code === 'Space') { e.preventDefault(); send({ t: 'estop' }); return; }
  keys.add(e.key.toLowerCase());
});
addEventListener('keyup', (e) => keys.delete(e.key.toLowerCase()));
addEventListener('blur', () => keys.clear());

// gamepad
let prevBtn = [];
function readPad() {
  const pads = navigator.getGamepads ? navigator.getGamepads() : [];
  for (const p of pads) {
    if (!p || !p.connected) continue;
    const dz = 0.14, ax = (i) => { const v = p.axes[i] || 0; return Math.abs(v) < dz ? 0 : v; };
    const b = p.buttons.map((x) => x.pressed);
    const edge = (i) => b[i] && !prevBtn[i];
    if (edge(0)) send({ t: 'mode', mode: 'stand' });
    if (edge(1)) send({ t: 'mode', mode: 'rest' });
    if (edge(2)) send({ t: 'mode', mode: 'crawl' });
    if (edge(3)) send({ t: 'mode', mode: 'trot' });
    if (edge(4) || edge(5) || edge(8)) send({ t: 'estop' });
    prevBtn = b;
    return { vx: -ax(1), vy: -ax(0), wz: -ax(2) };
  }
  return null;
}

let dpadCmd = null;
const clamp1 = (v) => Math.max(-1, Math.min(1, v));
function driveTick() {
  const pad = readPad();
  let vx = 0, vy = 0, wz = 0, src = 'none';
  if (pad && (pad.vx || pad.vy || pad.wz)) { vx += pad.vx; vy += pad.vy; wz += pad.wz; src = 'gamepad'; }
  if (stickMove.active || stickTurn.active) { vx += stickMove.y; vy += -stickMove.x; wz += -stickTurn.x; src = 'touch'; }
  if (keys.size) {
    vx += (keys.has('w') ? 1 : 0) - (keys.has('s') ? 1 : 0);
    vy += (keys.has('a') ? 1 : 0) - (keys.has('d') ? 1 : 0);
    wz += (keys.has('q') ? 1 : 0) - (keys.has('e') ? 1 : 0);
    if (vx || vy || wz) src = 'keyboard';
  }
  if (dpadCmd) {
    vx += dpadCmd.vx;
    vy += dpadCmd.vy;
    wz += dpadCmd.wz;
    src = 'dpad';
  }
  vx = clamp1(vx); vy = clamp1(vy); wz = clamp1(wz);
  if (Math.hypot(vx, vy) < 0.04 && Math.abs(wz) < 0.04) { vx = 0; vy = 0; wz = 0; }
  send({ t: 'drive', vx, vy, wz });               // sent every tick: the robot stops if these stop arriving
  $('#inputSrc').textContent = src;
  $('#cmdOut').textContent = `${vx.toFixed(2)} / ${vy.toFixed(2)} / ${wz.toFixed(2)}`;
}
setInterval(driveTick, 50);

/* ------------------------------------------------------------------ calibrate tab */
function buildCards() {
  const host = $('#cards'); host.innerHTML = '';
  if (!cal) return;
  const [lo, hi] = cal.pulse_abs;
  JOINTS.forEach((j) => {
    const s = cal.servos.find((x) => x.leg === selLeg && x.joint === j); if (!s) return;
    const pct = (us) => ((us - lo) / (hi - lo)) * 100;
    const card = document.createElement('div'); card.className = `card ${s.model}`; card.id = 'card-' + s.id;
    card.innerHTML = `
      <header><b>${LEG_NAME[selLeg]} ${j}</b><span>${s.model} · board <input type="text" data-f="board" value="${s.board || ''}" title="PCA9685 board"> · ch <input type="number" min="0" max="15" data-f="channel" value="${s.channel}" title="Channel (0-15)"></span></header>
      <div class="pulse"><b class="us">${s.us_center} µs</b><b class="dg">0.0°</b>
        <button class="en">Enable</button></div>
      <div class="track"><div class="band"><i style="left:${pct(s.us_min)}%;width:${pct(s.us_max) - pct(s.us_min)}%"></i><u style="left:${pct(s.us_center)}%"></u></div>
        <input type="range" min="${lo}" max="${hi}" step="1" value="${s.us_center}"></div>
      <div class="jog needs"><button data-d="-10">−10</button><button data-d="-1">−1</button><button data-d="1">+1</button><button data-d="10">+10</button></div>
      <div class="btnrow">
        <button class="needs" data-c="center">Set centre</button>
        <button class="needs" data-c="low">Set low</button>
        <button class="needs" data-c="high">Set high</button>
        <button data-c="invert" aria-pressed="${s.invert}">Invert</button>
        <button class="needs sweep">Sweep test</button>
      </div>
      <div class="fields">
        <label>µs per degree<input type="number" step="0.01" data-f="us_per_deg" value="${s.us_per_deg}"></label>
        <label>Max speed °/s<input type="number" step="5" data-f="max_speed_dps" value="${s.max_speed_dps}"></label>
        <label>Measured angle °<input type="number" step="1" class="meas" value="45"></label>
        <button class="needs scale">Calibrate scale</button>
      </div>`;
    host.appendChild(card);

    const slider = $('input[type=range]', card);
    slider.addEventListener('input', () => sendThrottled('us_' + s.id, { t: 'servo_us', id: s.id, us: +slider.value }, 30));
    $('.en', card).addEventListener('click', () => send({ t: 'servo_enable', id: s.id, on: !(st && st.live[s.id].en) }));
    $$('.jog button', card).forEach((b) => b.addEventListener('click', () => {
      const cur = st ? st.live[s.id].us : s.us_center;
      send({ t: 'servo_us', id: s.id, us: cur + +b.dataset.d });
    }));
    $$('button[data-c]', card).forEach((b) => b.addEventListener('click', () => {
      if (b.dataset.c === 'invert') { send({ t: 'servo_cal', id: s.id, field: 'invert', value: b.getAttribute('aria-pressed') !== 'true' }); }
      else send({ t: 'servo_cal', id: s.id, field: b.dataset.c });
    }));
    $('.sweep', card).addEventListener('click', () => send({ t: 'servo_sweep', id: s.id }));
    $('.scale', card).addEventListener('click', () => send({ t: 'servo_cal', id: s.id, field: 'scale_from', value: +$('.meas', card).value }));
    $$('input[data-f]', card).forEach((inp) => inp.addEventListener('change', () => send({ t: 'servo_cal', id: s.id, field: inp.dataset.f, value: inp.type === 'number' ? +inp.value : inp.value })));
  });
  $$('#legSeg button').forEach((b) => b.classList.toggle('on', b.dataset.leg === selLeg));
}

function updateCalLive() {
  if (!st || !cal) return;
  JOINTS.forEach((j) => {
    const sid = `${selLeg}_${j}`, card = document.getElementById('card-' + sid), v = st.live[sid];
    if (!card || !v) return;
    $('.us', card).textContent = `${Math.round(v.us)} µs`;
    $('.dg', card).textContent = `${v.deg.toFixed(1)}°`;
    const slider = $('input[type=range]', card);
    if (document.activeElement !== slider) slider.value = v.us;
    $('.en', card).textContent = v.en ? 'Release' : 'Enable';
    card.classList.toggle('on', v.en);
    card.classList.toggle('locked', !v.en || st.mode !== 'calib');
  });
}

$$('#legSeg button').forEach((b) => b.addEventListener('click', () => { selLeg = b.dataset.leg; buildCards(); updateCalLive(); drawChassis(); }));
$('#enableLeg').addEventListener('click', () => JOINTS.forEach((j) => send({ t: 'servo_enable', id: `${selLeg}_${j}`, on: true })));
$('#disableAll').addEventListener('click', () => send({ t: 'servo_enable', id: 'all', on: false }));
$('#saveCfg').addEventListener('click', () => send({ t: 'save' }));

function drawChassis() {
  const c = $('#chassis'), ctx = c.getContext && c.getContext('2d');
  if (!ctx || !cal || !st) return;
  const W = c.width, cx = W / 2, cy = W / 2, k = 0.5, g = cal.geometry;
  const P = (bx, by) => [cx - by * k, cy - bx * k];                 // body frame (x forward, y left) -> screen
  ctx.clearRect(0, 0, W, W);
  ctx.strokeStyle = '#c3cdd2'; ctx.lineWidth = 1;
  [100, 200, 300].forEach((r) => { ctx.beginPath(); ctx.arc(cx, cy, r * k, 0, 7); ctx.stroke(); });
  ctx.fillStyle = '#dfe6e9'; ctx.strokeStyle = '#14222b'; ctx.lineWidth = 2;
  const hx = Math.max(...LEGS.map((l) => Math.abs(cal.legs[l].hip_xy[0]))), hy = Math.max(...LEGS.map((l) => Math.abs(cal.legs[l].hip_xy[1])));
  const [x0, y0] = P(hx, hy), [x1, y1] = P(-hx, -hy);
  ctx.fillRect(Math.min(x0, x1), Math.min(y0, y1), Math.abs(x1 - x0), Math.abs(y1 - y0)); ctx.strokeRect(Math.min(x0, x1), Math.min(y0, y1), Math.abs(x1 - x0), Math.abs(y1 - y0));
  ctx.fillStyle = '#14222b'; ctx.font = '12px sans-serif'; ctx.textAlign = 'center'; ctx.fillText('front', cx, Math.min(y0, y1) - 6);

  LEGS.forEach((leg) => {
    const geo = cal.legs[leg], side = geo.side, [hpx, hpy] = geo.hip_xy;
    const d = (j) => (st.live[`${leg}_${j}`] ? st.live[`${leg}_${j}`].deg : 0.0);
    const th1 = rad(d('coxa')), a = rad(d('femur')), b = rad(d('tibia'));
    const gammaDeg = geo.gamma !== undefined ? geo.gamma : (side === 1 ? 45 : -45);
    const gamma = rad(gammaDeg);
    const ang = gamma - side * th1;

    const rCoxa = g.coxa;
    const rKnee = g.coxa + g.femur * Math.cos(a);
    const gam = a - Math.PI / 2 + b;
    const rFoot = g.coxa + g.femur * Math.cos(a) + g.tibia * Math.cos(gam);
    const zFoot = g.femur * Math.sin(a) + g.tibia * Math.sin(gam);

    const pts = [
      P(hpx, hpy),
      P(hpx + rCoxa * Math.cos(ang), hpy + rCoxa * Math.sin(ang)),
      P(hpx + rKnee * Math.cos(ang), hpy + rKnee * Math.sin(ang)),
      P(hpx + rFoot * Math.cos(ang), hpy + rFoot * Math.sin(ang))
    ];
    const sel = leg === selLeg;
    ctx.strokeStyle = sel ? '#276b8c' : '#4a5c66'; ctx.lineWidth = sel ? 5 : 3; ctx.lineJoin = 'round';
    ctx.beginPath(); pts.forEach(([x, y], i) => (i ? ctx.lineTo(x, y) : ctx.moveTo(x, y))); ctx.stroke();
    JOINTS.forEach((j, i) => {                                        // joint dots use the servo model colour, like the wiring sketch
      const s = cal.servos.find((q) => q.id === `${leg}_${j}`);
      ctx.fillStyle = (s && MODEL_COLOR[s.model]) || '#888'; ctx.strokeStyle = '#fff'; ctx.lineWidth = 2;
      ctx.beginPath(); ctx.arc(pts[i][0], pts[i][1], sel ? 8 : 6, 0, 7); ctx.fill(); ctx.stroke();
    });
    ctx.fillStyle = '#14222b'; ctx.fillRect(pts[3][0] - 3, pts[3][1] - 3, 6, 6);
    if (sel) { ctx.font = '12px sans-serif'; ctx.textAlign = 'left'; ctx.fillText(`foot z ${zFoot.toFixed(0)} mm`, pts[3][0] + 8, pts[3][1] + 4); }
  });
}
$('#chassis').addEventListener('click', (e) => {
  if (!cal) return;
  const c = e.target, r = c.getBoundingClientRect(), x = (e.clientX - r.left) * c.width / r.width, y = (e.clientY - r.top) * c.height / r.height;
  let best = null, bd = 1e9;
  LEGS.forEach((leg) => { const [hx, hy] = cal.legs[leg].hip_xy, sx = c.width / 2 - hy * 0.5, sy = c.width / 2 - hx * 0.5, d = Math.hypot(sx - x, sy - y); if (d < bd) { bd = d; best = leg; } });
  if (best) { selLeg = best; buildCards(); updateCalLive(); drawChassis(); }
});

/* ------------------------------------------------------------------ legs tab */
function buildLegSliders() {
  const host = $('#legSliders'); host.innerHTML = '';
  if (!cal) return;
  const t = (st && st.leg_targets[legTestLeg]) || [cal.reach, 0, -cal.gait.height_stand];
  const cur = [...t];
  const push = () => { sendThrottled('leg', { t: 'leg', leg: legTestLeg, x: cur[0], y: cur[1], z: cur[2] }, 40); };
  [['x  (out)', 40, 260, 0], ['y  (forward)', -120, 120, 1], ['z  (up)', -180, -10, 2]].forEach(([label, min, max, i]) =>
    mkSlider(host, { label, min, max, step: 1, unit: 'mm', value: cur[i], onInput: (v) => { cur[i] = v; push(); updateLegReadout(cur); } }));
  $$('#legSeg2 button').forEach((b) => b.classList.toggle('on', b.dataset.leg === legTestLeg));
  legCur = cur;
}
let legCur = null;
function updateLegReadout(cur) {
  if (!cal) return;
  const p = cur || legCur; if (!p) return;
  const r = ik(cal.geometry, p[0], p[1], p[2]);
  $('#lgC').textContent = deg(r.th1).toFixed(1) + '°'; $('#lgF').textContent = deg(r.a).toFixed(1) + '°'; $('#lgT').textContent = deg(r.b).toFixed(1) + '°';
  const ok = $('#lgOk'); ok.textContent = r.ok ? 'yes' : 'out of reach'; ok.style.color = r.ok ? 'var(--ok)' : 'var(--stop)';
}
$$('#legSeg2 button').forEach((b) => b.addEventListener('click', () => { legTestLeg = b.dataset.leg; buildLegSliders(); updateLegReadout(); }));
$('#startLegTest').addEventListener('click', () => send({ t: 'mode', mode: 'legtest' }));
$('#legNeutral').addEventListener('click', () => {
  if (!cal) return;
  LEGS.forEach((leg) => send({ t: 'leg', leg, x: cal.reach, y: 0, z: -cal.gait.height_stand }));
  setTimeout(() => { buildLegSliders(); updateLegReadout(); }, 150);
});

/* ------------------------------------------------------------------ radar tab */
function buildAvoidSliders() {
  const host = $('#avoidSliders'); host.innerHTML = '';
  const a = cal.avoid;
  [['stop_mm', 'Stop distance', 150, 800, 25, 'mm'], ['slow_mm', 'Start slowing at', 400, 2000, 50, 'mm'],
   ['arc_deg', 'Look-ahead arc ±', 15, 60, 5, '°'], ['turn_gain', 'Steer-around strength', 0.2, 1.5, 0.1, '']].forEach(([key, label, min, max, step, unit]) =>
    mkSlider(host, { label, min, max, step, unit, value: a[key], onInput: (v) => sendThrottled('a_' + key, { t: 'params', [key]: v }) }));
}
$('#chkAvoid').addEventListener('change', (e) => send({ t: 'params', avoid_enabled: e.target.checked }));
$('#chkDerate').addEventListener('change', (e) => send({ t: 'params', auto_derate: e.target.checked }));
$('#chkMock').addEventListener('change', (e) => send({ t: 'mock_obstacle', on: e.target.checked, dist_mm: 600 }));
$('#rngSlider').addEventListener('input', (e) => { rangeM = +e.target.value; $('#rngVal').textContent = rangeM.toFixed(1) + ' m'; drawRadar(); });

function drawRadar() {
  const c = $('#radar'), ctx = c.getContext && c.getContext('2d');
  if (!ctx) return;
  const W = c.width, cx = W / 2, cy = W / 2, R = W / 2 - 24, rangeMm = rangeM * 1000, k = R / rangeMm;
  const pos = (d, th) => [cx - d * k * Math.sin(th), cy - d * k * Math.cos(th)];
  ctx.clearRect(0, 0, W, W);
  const av = (cal && cal.avoid) || { stop_mm: 350, slow_mm: 900, arc_deg: 35 };
  const ring = rangeM <= 3 ? 500 : 1000;
  ctx.font = '18px sans-serif'; ctx.textAlign = 'left';
  for (let d = ring; d <= rangeMm + 1; d += ring) {
    ctx.strokeStyle = 'rgba(160,190,205,.25)'; ctx.lineWidth = 1; ctx.beginPath(); ctx.arc(cx, cy, d * k, 0, 7); ctx.stroke();
    ctx.fillStyle = 'rgba(160,190,205,.7)'; ctx.fillText((d / 1000).toFixed(1) + ' m', cx + 6, cy - d * k - 4);
  }
  ctx.strokeStyle = 'rgba(160,190,205,.25)'; ctx.beginPath(); ctx.moveTo(cx, cy - R); ctx.lineTo(cx, cy + R); ctx.moveTo(cx - R, cy); ctx.lineTo(cx + R, cy); ctx.stroke();
  // avoidance zones: red = stop, amber = slowing
  [[av.slow_mm, 'rgba(240,185,11,.16)'], [av.stop_mm, 'rgba(230,70,60,.30)']].forEach(([d, col]) => {
    const r = Math.min(d, rangeMm) * k;
    ctx.fillStyle = col; ctx.beginPath(); ctx.moveTo(cx, cy);
    ctx.arc(cx, cy, r, -Math.PI / 2 - rad(av.arc_deg), -Math.PI / 2 + rad(av.arc_deg)); ctx.closePath(); ctx.fill();
  });
  if (scan) {
    for (let i = 0; i < 360; i++) {
      const d = scan.d[i]; if (d <= 0 || d > rangeMm) continue;
      const [x, y] = pos(d, rad(i));
      ctx.fillStyle = d < av.stop_mm ? '#ff6b5e' : d < av.slow_mm ? '#f0b90b' : '#5ad1e6';
      ctx.fillRect(x - 2, y - 2, 4, 4);
    }
  }
  ctx.fillStyle = '#e7eef1'; ctx.beginPath(); ctx.moveTo(cx, cy - 18); ctx.lineTo(cx + 11, cy + 12); ctx.lineTo(cx - 11, cy + 12); ctx.closePath(); ctx.fill();
  if (target) {
    const [x, y] = pos(target.range, rad(target.bearing));
    ctx.strokeStyle = '#7dffb0'; ctx.lineWidth = 2; ctx.beginPath();
    ctx.moveTo(x - 10, y); ctx.lineTo(x + 10, y); ctx.moveTo(x, y - 10); ctx.lineTo(x, y + 10); ctx.stroke();
    ctx.beginPath(); ctx.arc(x, y, 7, 0, 7); ctx.stroke();
  }
  if (scan) {
    $('#lidAge').textContent = scan.age.toFixed(2) + ' s';
    const fm = st && st.avoid && st.avoid.front_mm;
    $('#lidFront').textContent = fm != null && isFinite(fm) ? (fm / 1000).toFixed(2) + ' m' : '-';
  }
}
$('#radar').addEventListener('click', (e) => {
  const c = e.target, r = c.getBoundingClientRect();
  const x = (e.clientX - r.left) * c.width / r.width - c.width / 2, y = c.height / 2 - (e.clientY - r.top) * c.height / r.height;
  const k = (c.width / 2 - 24) / (rangeM * 1000);
  target = { range: Math.hypot(x, y) / k, bearing: deg(Math.atan2(-x, y)) };
  const side = target.bearing >= 0 ? 'left' : 'right';
  $('#tgtInfo').textContent = `${(target.range / 1000).toFixed(2)} m, ${Math.abs(target.bearing).toFixed(0)}° ${side}`;
  drawRadar();
});

/* ------------------------------------------------------------------ chrome */
$('#arm').addEventListener('click', () => {
  const willArm = !(st && st.armed);
  send({ t: 'arm', on: willArm });
  if (willArm && st && ['stand', 'crawl', 'trot'].includes(st.mode)) {
    send({ t: 'servo_enable_all', on: true });
  }
});
$('#estop').addEventListener('click', () => { if (st && st.estop) send({ t: 'reset_estop' }); else send({ t: 'estop' }); });
$$('#modeSeg button').forEach((b) => b.addEventListener('click', () => {
  const mode = b.dataset.mode;
  if (!st || !st.armed) send({ t: 'arm', on: true });
  if (['stand', 'crawl', 'trot'].includes(mode)) {
    send({ t: 'servo_enable_all', on: true });
  }
  send({ t: 'mode', mode });
}));
$$('.tabs button').forEach((b) => b.addEventListener('click', () => {
  tab = b.dataset.tab;
  $$('.tabs button').forEach((x) => x.setAttribute('aria-selected', String(x === b)));
  $$('.tab').forEach((s) => { s.hidden = s.id !== 'tab-' + tab; });
  if (tab === 'calib') { if (st && st.mode !== 'calib') send({ t: 'mode', mode: 'calib' }); drawChassis(); }
  if (tab === 'radar') drawRadar();
  if (tab === 'legs') { buildLegSliders(); updateLegReadout(); }
}));
// once an e-stop is latched the button becomes the reset control
setInterval(() => { if (st) { $('#estop').textContent = st.estop ? 'Reset e-stop' : 'E-stop'; } }, 200);

/* ------------------------------------------------------------------ quick debug & actions */
const enableAllServos = () => send({ t: 'servo_enable_all', on: true });
const releaseAllServos = () => send({ t: 'servo_enable_all', on: false });

$('#enableAllNav')?.addEventListener('click', enableAllServos);
$('#releaseAllNav')?.addEventListener('click', releaseAllServos);
$('#btnEnableAllDrive')?.addEventListener('click', enableAllServos);
$('#btnReleaseAllDrive')?.addEventListener('click', releaseAllServos);

$('#btnQuickStand')?.addEventListener('click', () => send({ t: 'quick_test', action: 'stand' }));
$('#btnQuickCrawl')?.addEventListener('click', () => send({ t: 'quick_test', action: 'crawl_fwd' }));
$('#btnQuickBack')?.addEventListener('click', () => send({ t: 'quick_test', action: 'crawl_back' }));
$('#btnQuickTurnL')?.addEventListener('click', () => send({ t: 'quick_test', action: 'turn_left' }));
$('#btnQuickTurnR')?.addEventListener('click', () => send({ t: 'quick_test', action: 'turn_right' }));
$('#btnQuickZero')?.addEventListener('click', () => send({ t: 'quick_test', action: 'zero_1500' }));
$('#btnQuickStop')?.addEventListener('click', () => send({ t: 'quick_test', action: 'stop' }));

// Direction pad interaction (works for touch/pointer hold & mouse click)
$$('.dpad-btn').forEach((btn) => {
  const act = btn.dataset.act;
  const getCmd = (a) => {
    switch (a) {
      case 'fwd': return { vx: 0.65, vy: 0.0, wz: 0.0 };
      case 'back': return { vx: -0.65, vy: 0.0, wz: 0.0 };
      case 'left': return { vx: 0.0, vy: 0.65, wz: 0.0 };
      case 'right': return { vx: 0.0, vy: -0.65, wz: 0.0 };
      case 'turn_left': return { vx: 0.0, vy: 0.0, wz: 0.8 };
      case 'turn_right': return { vx: 0.0, vy: 0.0, wz: -0.8 };
      case 'stop': default: return null;
    }
  };
  const onStart = (e) => {
    e.preventDefault();
    if (act === 'stop') {
      dpadCmd = null;
      send({ t: 'quick_test', action: 'stop' });
      return;
    }
    dpadCmd = getCmd(act);
    btn.classList.add('active');
  };
  const onEnd = () => {
    dpadCmd = null;
    btn.classList.remove('active');
  };
  btn.addEventListener('pointerdown', onStart);
  btn.addEventListener('pointerup', onEnd);
  btn.addEventListener('pointerleave', onEnd);
  btn.addEventListener('pointercancel', onEnd);
});

// Scope selector listeners (individual leg, board, or servo isolation)
$$('#scopeSeg button').forEach((b) => {
  b.addEventListener('click', () => {
    const sc = b.dataset.scope;
    if (sc === 'all') {
      send({ t: 'servo_enable_all', on: true });
    } else if (['FL', 'FR', 'RL', 'RR'].includes(sc)) {
      send({ t: 'enable_leg', leg: sc, on: true, exclusive: true });
    } else if (['left', 'right'].includes(sc)) {
      send({ t: 'enable_board', board: sc, on: true, exclusive: true });
    }
  });
});

$('#btnEnableSingleServo')?.addEventListener('click', () => {
  const sid = $('#singleServoSelect')?.value;
  if (sid) {
    send({ t: 'enable_only', id: sid });
  }
});

connect();

