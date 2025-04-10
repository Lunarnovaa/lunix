import { bind } from "astal"
import { App, Astal, Gdk, Gtk } from "astal/gtk4"
import { Variable } from "astal"

import Apps from "gi://AstalApps"

const MAX_ITEMS = 8

function hide() {
    App.get_window("launcher")!.hide()
}

function AppButton({ app}: {app: Apps.Application}) {
    return <button
        onClicked={() => { hide(); app.launch() }}>
        <box>
            <image
                iconName={app.iconName}
            />
            <box valign={Gtk.Align.CENTER} vertical>
                <label
                    wrap
                    xalign={0}
                    label={app.name}
                />
                {app.description && <label
                    wrap
                    xalign={0}
                    label={app.description}
                />}
            </box>
        </box>
    </button>
}

export default function AppLauncher() {
    const { CENTER } = Gtk.Align
    const apps = new Apps.Apps()
    const width = Variable(1000)

    const text = Variable("")
    const list = text(text => apps.fuzzy_query(text).slice(0, MAX_ITEMS))
    const onEnter = () => {
        apps.fuzzy_query(text.get())?.[0].launch()
        hide()
    }

    return <window
        name="launcher"
        anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.BOTTOM}
        exclusivity={Astal.Exclusivity.IGNORE}
        keymode={Astal.Keymode.ON_DEMAND}
        application={App}
        onShow={(self) => {
            text.set("")
            width.set(self.get_current_monitor().workarea.width)
        }}
        onKeyPressEven={function (self, event: Gdk.Event) {
            if (event.get_keyval()[1] === Gdk.KEY_Escape)
                self.hide()
        }}>

    </window>
}
