using Events;
using Godot;
using Godot.Collections;

public partial class TestEmitter : Node
{
    [Export] private int value = 15;
    [Export] private IntEventChannel intEventChannel;

    private IntEvent intEvent;

    public override void _Ready()
    {
        intEvent = new IntEvent(value);

        PublishEvent();
    }

    public void _on_timer_timeout() => PublishEvent();

    private void PublishEvent() => intEventChannel?.Invoke(intEvent);
}
