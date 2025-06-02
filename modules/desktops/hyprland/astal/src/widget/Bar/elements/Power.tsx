import { Astal, Gtk } from "astal/gtk4";
import { Variable } from "astal";

const Show = Variable(false);
function Confirm(Show) {
  const { TOP } = Astal.WindowAnchor;

  return (
    <window exclusivity={Astal.Exclusivity.EXCLUSIVE} anchor={TOP} visible>
      <box hexpand visible>
        Shutdown?
      </box>
      <button onClicked="shutdown" label="Yes" />
      <button label="No" />
    </window>
  );
}

export default function Power() {
  return (
    <box
      name="Power"
      vexpand
      orientation={1}
      visible
      cssClasses={["element", "power"]}
    >
      <menubutton halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}>
        <popover>test</popover>
      </menubutton>
    </box>
  );
}
