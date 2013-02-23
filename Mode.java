public enum Mode {
	galileo("Galileo"),
	snow("Snowglobe");

	private final String name;

	private Mode(final String s) { name = s; }

	public String toString() {
		return name;
	}

	public Mode next() {
		return values()[(ordinal() + 1) % values().length];
	}
}
