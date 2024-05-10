

using Godot;
using System;

namespace Events
{
    public partial class FloatEventMiddleMan : EventMiddleMan<EventData<FloatEventData>>
    {
        [Export] private FloatEventChannel floatChannel;

        public void EmitEvent(float _float) => floatChannel?.Invoke(new FloatEventData(_float));

        public override void OnResponse(EventData<FloatEventData> _data) =>
            EmitSignal(SignalName.Middleman, _data.Value.floatValue);
    }
}
