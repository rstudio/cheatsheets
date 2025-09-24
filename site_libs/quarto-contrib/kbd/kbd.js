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

  const macosModifiers = {
    "command": "⌘",
    "cmd": "⌘",
    "shift": "⇧",
    "ctrl": "⌃",
    "control": "⌃",
    "option": "⌥",
  };
  const keyRegex = /^[^\s]+$/;
    // use a non-capturing group to avoid capturing the key names

  const macosModifiersRegex = new RegExp(
    // use a non-capturing group to avoid capturing the key names
    `^(?:${Object.keys(macosModifiers).join("|")})-`,
    "gi"
  );
  const shortcutParses = (text) => {
    text = text.toLocaleLowerCase();
    while (text.match(macosModifiersRegex)) {
      text = text.replace(macosModifiersRegex, "");
    }
    return text.match(keyRegex) !== null;
  }

  // deno-lint-ignore no-window-prefix
  window.addEventListener("DOMContentLoaded", (_) => {
    for (const el of Array.from(document.querySelectorAll("kbd"))) {
      el.classList.add("kbd");
      if (el.dataset[os.name] !== undefined) {
        el.innerText = el.dataset[os.name];
      }
      if (os.name === "mac" && shortcutParses(el.innerText)) {
        el.classList.add("mac");
        for (const [key, value] of Object.entries(macosModifiers)) {
          el.innerText = el.innerText.replaceAll(new RegExp(`${key}-`, "gi"), value);
        }
        el.innerText = el.innerText.toLocaleUpperCase();
      }
    }
  });
})();
