import { Variable, GLib } from "astal"


export default function Time({ format = "%H %M" }) {
    const time = Variable<string>("").poll(1000, () =>
        GLib.DateTime.new_now_local().format(format)!)

    return <label
        name="Time"
        onDestroy={() => time.drop()}
        label={time()}
         maxWidthChars={2}
        wrap
        cssClasses={["element", "time"]}
    />
}
