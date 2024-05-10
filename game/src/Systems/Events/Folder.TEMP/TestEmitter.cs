using Events;
using Godot;
using Godot.Collections;

public partial class TestEmitter : Node
{
    [Export] private float value = 15;
    [Export] private FloatEventChannel intEventChannel;

    private FloatEventData floatEvent;

    public override void _Ready()
    {
        floatEvent = new FloatEventData(value);

        PublishEvent();
    }

    public void _on_timer_timeout() => PublishEvent();

    private void PublishEvent() => intEventChannel?.Invoke(floatEvent);
}
