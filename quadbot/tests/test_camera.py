import pytest
from quadbot.camera import CameraManager


def test_camera_manager_lifecycle():
    cam = CameraManager(width=320, height=240, fps=15)
    assert not cam.enabled
    status = cam.get_status()
    assert status["enabled"] is False
    assert status["active"] is False

    # Toggle on
    is_on = cam.toggle(True)
    assert is_on is True
    assert cam.enabled is True

    # Standby frame test
    standby = cam._render_standby_frame("Test Standby")
    assert isinstance(standby, bytes)
    assert len(standby) > 0

    # Toggle off
    is_off = cam.toggle(False)
    assert is_off is False
    assert cam.enabled is False
    cam.stop_feed()
    assert cam.get_status()["enabled"] is False


def test_camera_toggle_inversion():
    cam = CameraManager()
    assert not cam.enabled
    assert cam.toggle() is True
    assert cam.enabled is True
    assert cam.toggle() is False
    assert cam.enabled is False
