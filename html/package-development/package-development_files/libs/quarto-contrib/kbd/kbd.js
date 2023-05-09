(() => {
  function guessOS() {
    const userAgent = window.navigator.userAgent;
    if (userAgent.includes("Mac OS")) {
      return {
        name: "mac",
      };
    } else if (userAgent.includes("Windows")) {
      return {
        name: "windows",
      };
    } else {
      return {
        name: "linux",
      };
    }
  }
  const os = guessOS();

  // deno-lint-ignore no-window-prefix
  window.addEventListener("DOMContentLoaded", (_) => {
    for (const el of Array.from(document.querySelectorAll("kbd"))) {
      el.classList.add("kbd");
      if (el.dataset[os.name] !== undefined) {
        el.innerText = el.dataset[os.name];
      }
      if (os.name === "mac") {
        el.innerText = el.innerText
          .replaceAll(/command-?/gi, "⌘")
          .replaceAll(/cmd-?/gi, "⌘")
          .replaceAll(/shift-?/gi, "⇧")
          .replaceAll(/ctrl-?/gi, "⌃")
          .replaceAll(/control-?/gi, "⌃")
          .replaceAll(/option-?/gi, "⌥");
      }
    }
  });
})();
