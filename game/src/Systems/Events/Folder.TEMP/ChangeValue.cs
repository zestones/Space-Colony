using Events;
using Godot;
using System;

public partial class ChangeValue : Node
{
    public void _on_listner_response(EventData<IntEvent> _data)
    {
        GD.Print($"Value is {_data.Value.intValue}");
    }
}
