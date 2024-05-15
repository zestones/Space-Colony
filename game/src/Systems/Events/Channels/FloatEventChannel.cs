using Godot;

namespace Events
{
	[GlobalClass]
	public partial class FloatEventChannel : EventChannel<FloatEventData> { }
	public struct FloatEventData : IEventData
	{
		public readonly float floatValue;

		public FloatEventData(float _floatValue)
		{
			floatValue = _floatValue;
		}
	}
}
