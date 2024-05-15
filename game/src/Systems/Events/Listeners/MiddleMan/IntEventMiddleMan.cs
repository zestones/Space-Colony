using Godot;

namespace Events
{
    public partial class IntEventMiddleMan : EventMiddleMan<EventData<IntEventData>>
    {
        [Export] private IntEventChannel intChannel;

        public void EmitEvent(int _int) => intChannel?.Invoke(new IntEventData(_int));

        public override void OnResponse(EventData<IntEventData> _data) => EmitSignal(SignalName.Middleman, _data.Value.intValue);
    }
}
