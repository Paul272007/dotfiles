import Wp from "gi://AstalWp"

function AudioSlider() {
  const speaker = Wp.get_default()?.audio.default_speaker!

  return (
    <box className="Audio">
      <icon icon={bind(speaker, "volumeIcon")} />
      <label
        label={bind(speaker, "volume").as((v) => `${Math.round(v * 100)}%`)}
      />
    </box>
  )
}
