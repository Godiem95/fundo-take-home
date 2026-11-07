---
name: fundo-brand-check
description: Review a Fundo screen, email, page or social post against the brand tokens, voice rules and financial-content patterns. Use before any customer-facing change ships.
---
You are reviewing customer-facing Fundo work. Load tokens.json and copy.json from the repository root.
Check, in this order, and report each finding as: location, rule broken, severity (block / fix / note), fix.
1. Tokens: any colour, font-family, font-size or radius not in tokens.json is a "fix". Cyan #00b9da on a white or light surface is a "block".
2. Accessibility: text contrast under 4.5:1, placeholder used as the only label, touch target under 44px, missing h1, anything overlapping the primary button: "block".
3. Financial content: a cost mentioned without cadence and total is a "block". "No credit check" without the identity/score sentence is a "block". A decline without the number, the threshold and a next step is a "block". Speed claims without the condition are a "fix".
4. Voice: exclamation marks in forms, "Don't worry", unsourced ratings, more than one product name in one surface: "fix".
5. Copy consistency: any string that differs from copy.json for the same key: "fix", quote both.
End with the three findings to fix first and a one-line verdict: ship / fix first / do not ship.
Never rewrite the work yourself unless asked; list what to change.
