# SmartLinx

Progetto app android & ios smart home

## Coding Guide

Organizzazione delle Cartelle:

    Crea una cartella "pages" che contenga sottocartelle per ciascuna pagina dell'app.
    Ogni sottocartella deve contenere il file della pagina (es. home_page.dart) e una cartella "widget" con tutti i widget utilizzati in quella pagina (es. weather_wid.dart).
  
  Mantenere il Codice Pulito:

    Presta attenzione a mantenere il codice pulito per evitare incasinamenti.
    Cerca di mantenere un codice semplice non troppo intricato.
    Il codice deve essere scritto interamente in inglese
    
Struttura delle Pagine:

    Dividi ogni pagina in widget per ridurre il numero di righe in ciascuna classe.
    Cerca di rendere il codice più leggibile, separando le parti logiche da quelle grafiche quando possibile.
    
Divisione Codice Logico e Grafico:

    Divide il codice della parte grafica da quello della parte logica.
    Ad esempio, nella classe "devices", utilizza:
    devices_page.dart per la parte grafica.
    devices_logic.dart per la parte logica.
    widget/device_wid.dart per i widget specifici.
    
    
Gestione delle Versioni:

    Dopo ogni sessione di codifica, esegui un breve debug e verifica che tutto sia corretto.
    Esegui push e commit su GitHub per mantenere il repository aggiornato.

Segnalazione di Problemi:

    In caso di problemi o bug, inserisci commenti esplicativi nel codice.
    Usa commenti per indicare le sezioni che richiedono attenzione o correzioni.
    
    
Commenti Iniziali:

    Inizia ogni classe con un commento che includa:
    Il nome della classe.
    Una breve spiegazione di cosa fa la classe.
    Lo stato attuale della classe (in fase di lavorazione, completato, necessario debug, ecc.).

Riciclaggio dei Widget:

    Cerca di utilizzare il riciclaggio dei widget per ridurre la ridondanza del codice.
    Crea widget riutilizzabili che possono essere impiegati più volte nell'app.
    
Colori e temi:

    Ogni singolo tema e TextStyle | TextTheme utilizzato all'interno dell'app deve essere riconducibile alla classe Theme che ne definisce le proprietà, in modo tale da aver accesso         
    all'interscambiabilità dei temi
