export function initCodeGenStore() {
  document.addEventListener("alpine:init", () => {
    const codeGenValue = {
      enabled: false,
      init() {
        const codeGen = localStorage.getItem("codeGen");
        if (codeGen) {
          this.enabled = codeGen === "true";
        }
        localStorage.setItem("codeGen", this.enabled.toString());
      },
      toggle() {
        this.enabled = !this.enabled;
        localStorage.setItem("codeGen", this.enabled.toString());
      },
    };
    Alpine.store("codeGen", codeGenValue);
  });
}
