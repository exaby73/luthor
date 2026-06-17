function readCodeGenPreference() {
  try {
    return localStorage.getItem("codeGen") === "true";
  } catch {
    return false;
  }
}

function writeCodeGenPreference(enabled) {
  try {
    localStorage.setItem("codeGen", enabled.toString());
  } catch {}
}

function setCodeGenState(enabled) {
  document.documentElement.dataset.codeGen = enabled.toString();
}

setCodeGenState(readCodeGenPreference());

document.addEventListener("alpine:init", () => {
  const codeGenValue = {
    enabled: document.documentElement.dataset.codeGen === "true",
    init() {
      writeCodeGenPreference(this.enabled);
      setCodeGenState(this.enabled);
    },
    toggle() {
      this.enabled = !this.enabled;
      writeCodeGenPreference(this.enabled);
      setCodeGenState(this.enabled);
    },
  };
  Alpine.store("codeGen", codeGenValue);
});
