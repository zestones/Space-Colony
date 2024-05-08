using Events;
using Godot;
using Godot.Collections;

public partial class TestEmitter : Node
{
    [Export] private int value = 15;
    [Export] private Dictionary dicValues;
    [Export] private IntEventChannel intEventChannel;

    public override void _Ready()
    {
        PublishEvent();
    }

    private void PublishEvent()
    {
        if (intEventChannel != null)
            intEventChannel.Invoke(new IntEvent(value), dicValues);
    }
}
