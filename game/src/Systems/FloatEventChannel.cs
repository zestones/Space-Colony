using Godot;

namespace Events
{
    [GlobalClass]
    public partial class FloatEventChannel : EventChannel<FloatEvent> { }
    public readonly struct FloatEvent : IEventData
    {
        public readonly float floatValue;

        public FloatEvent(float _floatValue)
        {
            floatValue = _floatValue;
        }
    }
}
