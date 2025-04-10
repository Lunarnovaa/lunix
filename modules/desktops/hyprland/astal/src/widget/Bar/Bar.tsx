import { Astal, Gtk } from "astal/gtk4"


import Workspaces from "./elements/Workspaces"
import SysTray from "./elements/SysTray"
import Time from "./elements/Time"
import Power from "./elements/Power"

export default function Bar(monitor = 0) {
    const { TOP, LEFT, BOTTOM } = Astal.WindowAnchor
    return <window 
        visible
        cssClasses={["Bar"]} 
        name="bar"
        monitor={monitor}
        exclusivity={Astal.Exclusivity.EXCLUSIVE}
        anchor={TOP | LEFT | BOTTOM}>
        <centerbox orientation={1}>
            <box orientation={1} vexpand valign={Gtk.Align.START}>
                
            </box>
            <box orientation={1}>
                <Workspaces/>
            </box>
            <box orientation={1} vexpand valign={Gtk.Align.END}>
                <SysTray />
                <Time/>
                <button onClicked="poweroff">P</button>
            </box>
        </centerbox>
    </window>
}
