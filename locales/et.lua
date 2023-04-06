local Translations = {
    cruise = {
        unavailable = "Cruise control unavailable",
        activated = "Cruise Activated: ",
        deactivated = "Cruise Deactivated"
    },
    seatbelt = {
        use_harness_progress = "Attaching Race Harness",
        remove_harness_progress = "Removing Race Harness",
        no_car = "You're not in a car."
    }
}

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
