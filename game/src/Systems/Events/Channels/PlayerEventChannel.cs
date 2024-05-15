using Godot;
using Godot.Collections;

namespace Events
{
    [GlobalClass]
    public partial class PlayerEventChannel : EventChannel<PlayerEventData>{ }

    public struct PlayerEventData : IEventData
    {
        public Array playerData;

        public PlayerEventData(Array _data)
        {
            playerData = _data;
        }
    }
}
