using Godot;

namespace Events
{
    [GlobalClass]
    public partial class IntEventChannel : EventChannel<IntEvent> { }

    public readonly struct IntEvent : IEventData
    {
        public readonly int intValue;

        public IntEvent(int _intValue)
        {
            intValue = _intValue;
        }
    }
}
