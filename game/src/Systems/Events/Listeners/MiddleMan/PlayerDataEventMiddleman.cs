using Godot;

namespace Events
{
    public partial class PlayerDataEventMiddleman : EventMiddleMan<EventData<PlayerEventData>>
    {
        [Export] private PlayerEventChannel playerEventChannel;

        public void EmitEvent(Godot.Collections.Array _array) => playerEventChannel?.Invoke(new PlayerEventData(_array));

        public override void OnResponse(EventData<PlayerEventData> _data) => EmitSignal(SignalName.Middleman, _data.Value.playerData);
    }
}
