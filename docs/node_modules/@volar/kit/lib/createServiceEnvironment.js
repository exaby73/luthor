"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createServiceEnvironment = void 0;
const language_service_1 = require("@volar/language-service");
const fs = require("fs");
const vscode_uri_1 = require("vscode-uri");
const utils_1 = require("./utils");
function createServiceEnvironment(getSettings) {
    return {
        workspaceFolder: vscode_uri_1.URI.file(process.cwd()).toString(),
        getConfiguration(section) {
            const settings = getSettings();
            if (section in settings) {
                return settings[section];
            }
            let result;
            for (const settingKey in settings) {
                if (settingKey.startsWith(`${section}.`)) {
                    const value = settings[settingKey];
                    const props = settingKey.substring(section.length + 1).split('.');
                    result ??= {};
                    let current = result;
                    while (props.length > 1) {
                        const prop = props.shift();
                        if (typeof current[prop] !== 'object') {
                            current[prop] = {};
                        }
                        current = current[prop];
                    }
                    current[props.shift()] = value;
                }
            }
            return result;
        },
        fs: nodeFs,
        console,
        typescript: {
            fileNameToUri: utils_1.fileNameToUri,
            uriToFileName: utils_1.uriToFileName,
        },
    };
}
exports.createServiceEnvironment = createServiceEnvironment;
const nodeFs = {
    stat(uri) {
        if (uri.startsWith('file://')) {
            try {
                const stats = fs.statSync((0, utils_1.uriToFileName)(uri), { throwIfNoEntry: false });
                if (stats) {
                    return {
                        type: stats.isFile() ? language_service_1.FileType.File
                            : stats.isDirectory() ? language_service_1.FileType.Directory
                                : stats.isSymbolicLink() ? language_service_1.FileType.SymbolicLink
                                    : language_service_1.FileType.Unknown,
                        ctime: stats.ctimeMs,
                        mtime: stats.mtimeMs,
                        size: stats.size,
                    };
                }
            }
            catch {
                return undefined;
            }
        }
    },
    readFile(uri, encoding) {
        if (uri.startsWith('file://')) {
            try {
                return fs.readFileSync((0, utils_1.uriToFileName)(uri), { encoding: encoding ?? 'utf-8' });
            }
            catch {
                return undefined;
            }
        }
    },
    readDirectory(uri) {
        if (uri.startsWith('file://')) {
            try {
                const dirName = (0, utils_1.uriToFileName)(uri);
                const files = fs.readdirSync(dirName, { withFileTypes: true });
                return files.map(file => {
                    return [file.name, file.isFile() ? language_service_1.FileType.File
                            : file.isDirectory() ? language_service_1.FileType.Directory
                                : file.isSymbolicLink() ? language_service_1.FileType.SymbolicLink
                                    : language_service_1.FileType.Unknown];
                });
            }
            catch {
                return [];
            }
        }
        return [];
    },
};
//# sourceMappingURL=createServiceEnvironment.js.map