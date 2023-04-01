local Translations = {
    cruise = {
        unavailable = "Cruise control unavailable",
        activated = "Cruise Activated: ",
        deactivated = "Cruise Deactivated"
    }
}

if GetConvar('qb_locale', 'en') == 'et' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
