using Godot;

namespace Events
{
    [GlobalClass]
    public partial class IntEventChannel : EventChannel<IntEventData> { }

    public readonly struct IntEventData : IEventData
    {
        public readonly int intValue;

        public IntEventData(int _intValue)
        {
            intValue = _intValue;
        }
    }
}
