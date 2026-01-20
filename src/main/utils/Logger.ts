import * as vscode from "vscode";

const channel = vscode.window.createOutputChannel("Kontakt Lua API", { log: true });

function isDebug(): boolean {
    return process.env.VSCODE_DEBUG_MODE === "true"
        || process.env.NODE_ENV === "development";
}

export const logger = {
    info(message: string) {
        channel.info(message);
    },

    warn(message: string) {
        channel.warn(message);
    },

    error(message: string, err?: unknown) {
        if (err instanceof Error) {
            channel.error(`${message}: ${err.message}\n${err.stack}`);
        } else if (err) {
            channel.error(`${message}: ${String(err)}`);
        } else {
            channel.error(message);
        }
    },

    debug(message: string) {
        if (isDebug()) {
            channel.debug(message);
        }
    },

    show() {
        channel.show(true);
    }
};