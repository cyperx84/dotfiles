// Zen Browser — curated portable preferences
// Sourced by hand from prefs.js; excludes telemetry, session IDs, counters,
// GMP/plugin state, and machine-specific workspace UUIDs (all of which Zen
// regenerates or Firefox Sync carries). Zen reads user.js on startup and
// re-applies these into prefs.js, so this stays authoritative across machines.
//
// To add a pref: set it in Zen, find its `user_pref(...)` line in prefs.js,
// and copy the line here (change `user_pref` stays the same — user.js uses it too).

// --- Appearance / layout ---
user_pref("browser.theme.toolbar-theme", 0);            // dark toolbar
user_pref("zen.view.window.scheme", 0);
user_pref("zen.view.compact.enable-at-startup", false); // don't start in compact mode
user_pref("zen.view.compact.toolbar-flash-popup", true);
user_pref("sidebar.visibility", "hide-sidebar");
user_pref("font.name.serif.x-western", "Myna");
user_pref("font.size.variable.x-western", 14);
user_pref("layout.css.prefers-color-scheme.content-override", 0); // force dark to sites

// --- Behaviour ---
user_pref("zen.glance.activation-method", "shift");
user_pref("zen.pinned-tab-manager.restore-pinned-tabs-to-pinned-url", true);
user_pref("browser.urlbar.placeholderName", "Google");
user_pref("browser.urlbar.placeholderName.private", "Google");
user_pref("dom.forms.autocomplete.formautofill", true);
user_pref("accessibility.typeaheadfind.flashBar", 0);

// --- Privacy choices ---
user_pref("signon.rememberSignons", false);             // no built-in password manager
user_pref("privacy.history.custom", true);
user_pref("privacy.clearOnShutdown_v2.formdata", true);

// --- First-run suppression (skip onboarding on a fresh machine) ---
user_pref("zen.welcome-screen.seen", true);
user_pref("browser.bookmarks.restore_default_bookmarks", false);
