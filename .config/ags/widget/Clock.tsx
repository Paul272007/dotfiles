import { Variable, bind } from "astal"

const time = Variable("").poll(1000, 'date +"%H:%M"')

function Clock() {
  return <label className="Clock" label={bind(time)} />
}
