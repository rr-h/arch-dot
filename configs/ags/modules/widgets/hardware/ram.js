import { Box, Button, Label, CircularProgress } from 'resource:///com/github/Aylur/ags/widget.js'
import { execAsync } from 'resource:///com/github/Aylur/ags/utils.js';

const label = Label({
    className: "ram-inner",
    label: ""
})

const button = Button({
    className: "unset no-hover",
    child: label,
    onClicked: () => showHardwareMenu(),
});

const progress = CircularProgress({
    className: "ram",
    startAt: 0,
    rounded: false,
    // inverted: true,
    child: button,
});

export const RamWidget = () => Box({
    css: "margin-left: 1.0em;",
    connections: [
        [30000, box => {
            execAsync(`/home/ahmed/.config/ags/scripts/ram.sh`)
                .then(val => {
                    progress.value = (val / 100);
                    label.tooltipMarkup = `<span weight='bold' foreground='#79A7EC'>نسبة الرام المستهلكة (${val}%)</span>`
                }).catch(print);

            box.children = [
                progress
            ];
            box.show_all();
        }],
    ],
});
