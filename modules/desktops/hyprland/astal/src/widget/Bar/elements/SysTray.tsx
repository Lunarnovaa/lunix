import { bind } from "astal"
import { Gtk } from "astal/gtk4"

import Wp from "gi://AstalWp"
import Network from "gi://AstalNetwork"
import Bluetooth from "gi://AstalBluetooth"
import Battery from "gi://AstalBattery"

function AudioSlider() {
    const speaker = Wp.get_default()?.audio.defaultSpeaker!

    return <menubutton direction={Gtk.ArrowType.RIGHT} valign={Gtk.Align.CENTER}>
        <image iconName={bind(speaker, "volumeIcon")}/>
        <popover hasArrow={false}>
            <box>
                <slider
                    widthRequest={150}
                    onNotify={({value}) => (speaker.set_volume(value))}
                    value={bind(speaker,"volume")}
                    round_digits={2}
                />
                <button onClicked="pwvucontrol">
                    <image 
                        iconName={bind(speaker,"volumeIcon")}
                    />
                </button>
            </box>
        </popover>
    </menubutton>
}

function BatteryLevel() {
        const bat = Battery.get_default()
        
        return <box visible={bind(bat,"isPresent")}>
                <image 
                        tooltipText={bind(bat, "percentage").as(p =>
            `${Math.floor(p * 100)}%`
        )}
                        iconName={bind(bat, "batteryIconName")}
                />
        </box>
}

function Wifi() {
    const network = Network.get_default()
    const wifi = bind(network, "wifi")
    const wired = bind(network, "wired")

    let content
    
        if (wired.as(Boolean)) {
                content = wired.as(wired => wired && (
                        <image
                                tooltipText="Wired"
                                iconName={bind(wired,"iconName")}
                        />
                ))
        
        } else if (wifi.as(Boolean)) {
        content = wifi.as(wifi => wifi && (
            <image
                tooltipText={bind(wifi, "ssid").as(String)}
                iconName={bind(wifi, "iconName")}
            />
        ))
        } else {
        content = wifi.as(wifi => wifi && (

           <image
               tooltipText="Disconnected"
               iconName={bind(wifi, "iconName")}
           />
        ))}
        
    return <button onClicked="alacritty -e nmtui">{content}</button>
}

function BT() {
        const bluetooth = Bluetooth.get_default()

        let icon

        if (bluetooth.get_is_connected()) {
                icon = "󰂱"
        } else if (bluetooth.get_is_powered()) {
                icon = "󰂯"
        } else if (!bluetooth.get_is_powered()) {
                icon = "󰂲"
        } else {
                icon = "?"
        }

        return <button
                onClicked="blueberry"
        >
                <label label={icon}/>
        </button>
}

export default function SysTray() {
    return <box
        name = "SysTray"
        orientation={1}
        cssClasses={["element", "systray"]}
        visible>
            <AudioSlider/>
            <BatteryLevel/>
            <Wifi/>
            <BT/>
    </box>
}
