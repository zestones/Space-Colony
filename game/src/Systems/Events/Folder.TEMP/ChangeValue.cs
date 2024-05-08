using Events;
using Godot;

public partial class ChangeValue : HSlider
{
    public void _on_response(EventData<IntEvent> _data)
    {
        GD.Print($"Value is {_data.Value.intValue}");

        Value += _data.Value.intValue;
    }
}
