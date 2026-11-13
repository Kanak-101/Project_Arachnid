import pytest
from quadbot.camera import CameraManager


def test_camera_manager_lifecycle():
    cam = CameraManager(width=320, height=240, fps=15)
    # Default is enabled on creation
    assert cam.enabled is True
    status = cam.get_status()
    assert status["enabled"] is True

    # Standby frame test
    standby = cam._render_standby_frame("Test Standby")
    assert isinstance(standby, bytes)
    assert len(standby) > 0

    # get_latest_jpeg always returns valid bytes
    jpeg = cam.get_latest_jpeg()
    assert isinstance(jpeg, bytes)
    assert len(jpeg) > 0

    # Toggle off
    is_off = cam.toggle(False)
    assert is_off is False
    assert cam.enabled is False
    cam.stop_feed()
    assert cam.get_status()["enabled"] is False

    # Toggle back on
    is_on = cam.toggle(True)
    assert is_on is True
    assert cam.enabled is True
    cam.stop_feed()


def test_camera_toggle_inversion():
    cam = CameraManager()
    assert cam.enabled is True
    assert cam.toggle() is False
    assert cam.enabled is False
    assert cam.toggle() is True
    assert cam.enabled is True
    cam.stop_feed()
