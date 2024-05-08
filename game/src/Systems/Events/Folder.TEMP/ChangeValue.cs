using Events;
using Godot;
using System;

public partial class ChangeValue : Node
{
    public void _on_response(EventData<IntEvent> _data, object[] _value)
    {
        GD.Print($"Value is {_data.Value.intValue} int value {_value[0]}");
    }
}
