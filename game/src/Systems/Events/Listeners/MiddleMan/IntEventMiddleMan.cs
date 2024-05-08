using Godot;

namespace Events
{
    public partial class IntEventMiddleMan : EventMiddleMan<EventData<IntEvent>>
    {
        public override void OnResponse(EventData<IntEvent> _data)
        {
            EmitSignal(SignalName.Middleman, _data.Value.intValue);
        }
    }
}
