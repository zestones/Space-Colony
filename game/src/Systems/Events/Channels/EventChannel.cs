using Godot;
using Godot.Collections;
using System.Collections.Generic;

namespace Events
{

    public abstract partial class EventChannel<T> : Resource where T : IEventData
    {
        private readonly HashSet<EventListener<T>> observers = new();

        public void Invoke(T _value)
        {
            foreach (EventListener<T> observer in observers)
            {
                observer.Raise(_value);
            }
        }

        public void Register(EventListener<T> _observer) => observers.Add(_observer);
        public void Deregister(EventListener<T> _observer) => observers.Remove(_observer);
    }
}
