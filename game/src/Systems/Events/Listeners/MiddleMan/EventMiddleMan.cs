using Godot;

namespace Events
{
    public abstract partial class EventMiddleMan<T> : Node
    {
        [Signal] public delegate void MiddlemanEventHandler();

        public abstract void OnResponse(T _data);
    }
}
