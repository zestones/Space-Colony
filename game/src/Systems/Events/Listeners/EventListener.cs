using Godot;
using Godot.Collections;

namespace Events
{
    public abstract partial class EventListener<T> : Node where T : IEventData
    {
        [Export] private EventChannel<T> eventChannel;
        [Signal] public delegate void responseEventHandler();

        public override void _EnterTree()
        {
            eventChannel.Register(this);
        }

        public override void _ExitTree()
        {
            eventChannel.Deregister(this);
        }

        public void Raise(T _value)
        {
            GD.Print("Event being raised");

            EmitSignal(SignalName.response, args: new EventData<T>(_value));
        }
    }

    public partial class EventData<T> : GodotObject where T : IEventData
    {
        public T Value { get; private set; }

        public EventData(T value)
        {
            Value = value;
        }
    }

    public interface IEventData { }
}
