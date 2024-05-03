using Events;
using Godot;

public partial class TestEmitter : Node
{
    [Export] private int value = 15;
    [Export] private IntEventChannel intEventChannel;

    public override void _Ready()
    {
        PublishEvent();
    }

    private void PublishEvent()
    {
        if (intEventChannel != null)
            intEventChannel.Invoke(value);
    }
}
