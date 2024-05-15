using Events;
using Godot;

public partial class IntChangeValue : HSlider
{
    public void _on_response(EventData<IntEventData> _data)
    {
        GD.Print($"Value is {_data.Value.intValue}");

        Value += _data.Value.intValue;
    }
}
