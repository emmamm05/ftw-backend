require 'test_helper'

class EventAccelerometersControllerTest < ActionController::TestCase
  setup do
    @event_accelerometer = event_accelerometers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_accelerometers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_accelerometer" do
    assert_difference('EventAccelerometer.count') do
      post :create, event_accelerometer: { state: @event_accelerometer.state, wristband_id: @event_accelerometer.wristband_id }
    end

    assert_redirected_to event_accelerometer_path(assigns(:event_accelerometer))
  end

  test "should show event_accelerometer" do
    get :show, id: @event_accelerometer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_accelerometer
    assert_response :success
  end

  test "should update event_accelerometer" do
    patch :update, id: @event_accelerometer, event_accelerometer: { state: @event_accelerometer.state, wristband_id: @event_accelerometer.wristband_id }
    assert_redirected_to event_accelerometer_path(assigns(:event_accelerometer))
  end

  test "should destroy event_accelerometer" do
    assert_difference('EventAccelerometer.count', -1) do
      delete :destroy, id: @event_accelerometer
    end

    assert_redirected_to event_accelerometers_path
  end
end
