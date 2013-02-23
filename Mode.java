public enum Mode {
	galileo, snow;

	Mode next() {
		return values()[(ordinal() + 1) % values().length];
	}
}
