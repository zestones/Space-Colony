using Godot;

namespace Events
{
    public partial class EventData<T> : GodotObject where T : IEventData
    {
        public T Value { get; private set; }

        public EventData(T value)
        {
            Value = value;
        }
    }

    public interface IEventData
    {
    }
}
