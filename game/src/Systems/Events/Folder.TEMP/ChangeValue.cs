using Events;
using Godot;

public partial class ChangeValue : HSlider
{
    public void _on_response(EventData<FloatEventData> _data)
    {
        GD.Print($"Value is {_data.Value.floatValue}");

        Value += _data.Value.floatValue;
    }
}
