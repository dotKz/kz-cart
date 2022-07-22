local fr = {
    error = {
      error = 'Erreur, veuillez contacter le support',
      error_cid = 'Erreur, le CID n\'est pas reconnu',
      putinno = 'Ce chariot ne vous appartient pas',
      putinerr = 'Chariot non reconnu, veuillez contacter un admin (/report)',
      inverr = 'Chariot non reconnu, veuillez contacter un admin (/report)',
      buy = 'Pas assez d\'argent',
      buy_sub_c = 'Pas assez d\'argent dans vos poches!',
      buy_sub_b = 'Pas assez d\'argent dans en banque!',
      maxwagon_sub = 'Vous ne pouvez avoir que 3 chariots maximum!',
      maxwagon = 'Erreur',
    },

    success = {
      putin = 'Chariot rangé',
      give = 'Donation',
      give_sub = 'Vous avez donné le chariot ',
      give_sub2 = 'au joueur',
      sell = 'Vente',
      sell_sub = 'Vous avez vendu un chariot!',
      buy = 'Achat',
      buy_sub = 'Vous avez acheté un chariot!',


    },

    menu = {
      close = 'Fermer',
      wagon = 'Mes chariots',
      wagon_sub = 'Voir vos chariots stockés dans l\'écurie',
      buywagon = 'Acheter un chariot',
      buywagon_sub = 'De tout type pour tout les budgets!',
      sellwagon = 'Vendre un chariot',
      sellwagon_sub = 'Vous pouvez vous en séparer pour pas chère !',
      givewagon = 'Donner un chariot',
      givewagon_sub = 'Vous pouvez en faire don, attention cela est irréversible !',
      header = 'Ecurie de',
      header_sub = 'Vos chariots',
      header_glob = 'Ecurie',
      nowagon = 'Aucun chariot',
      nowagon_sub = 'Vous n\'avez pas de chariot dans cette écurie',
      nowagon_global_sub = 'Vous n\'avez pas de chariot',
      takeout = 'Sortir',
      etat = 'Etat',
      sellm ='Vendre',
      sell = 'Confirmation',
      sell_confirm = 'Confirmer la vente de votre chariot',
      sell_confirm_sub = 'Vous le vendrez 1/5 de son prix d\'achat',
      buy = 'Acheter un chariot',
      price = 'Prix',
      typebuy = 'Type de paiement';
      cash = 'Paiement cash',
      cash_sub1 = 'Payer',
      cash_sub2 = 'en cash',
      bank = 'Paiement via banque',
      bank_sub1 = 'Prélever',
      bank_sub2 = 'de votre compte en banque',
      give = 'Donner',

    },

    input = {
      validate = 'Valider',
      namewagon = 'Nommer votre chariot',
      namewagon_text = '(Nom de votre chariot)',
      giveid = 'Veuillez indiquer l\'ID Permanent du destinataire (/cid)',
      giveid_text = '(ATTENTION CASE SENSIBLE)',
    },

    state = {
      _out = 'Sortie',
      _in = 'Rangé',
      _ss = 'Saisie',
      check = 'Vérifications, veuillez patienter !',
      out = 'Ce chariot est déjà sorti !',
      ssheriff = 'Ce chariot a été saisi par les sheriff !',
    },

    other = {
      blips = 'Charron',
      prompt = 'Ouvrir le Charron',
    },

}

----------------------------------------------------------------------------------------
-- Hello Google Translate

local en = {
  error = {
    error = 'Error, please contact support',
    error_cid = 'Error, CID is not recognized',
    putinno = 'This cart does not belong to you',
    putinerr = 'Cart not recognized, please contact an admin (/report)',
    inverr = 'Cart not recognized, please contact an admin (/report)',
    buy = 'Not enough money',
    buy_sub_c = 'Not enough money in your pocket!',
    buy_sub_b = 'Not enough money in the bank!',
    maxwagon_sub = 'You can only have a maximum of 3 carts!',
    maxwagon = 'Mistake',
  },

  success = {
    putin = 'Stored trolley',
    give = 'Donation',
    give_sub = 'You gave the cart ',
    give_sub2 = 'to the player',
    sell = 'Sale',
    sell_sub = 'You sold a cart!',
    buy = 'Purchase',
    buy_sub = 'You bought a trolley!',


  },

  menu = {
    close = 'Close',
    wagon = 'My carts',
    wagon_sub = 'See your carts stored in the stable',
    buywagon = 'Buy a trolley',
    buywagon_sub = 'All types for all budgets!',
    sellwagon = 'Sell ​​a cart',
    sellwagon_sub = 'You can part with it for cheap !',
    givewagon = 'Give a cart',
    givewagon_sub = 'You can donate it, be careful this is irreversible !',
    header = 'Stable of',
    header_sub = 'Your trolleys',
    header_glob = 'Stable',
    nowagon = 'No trolley',
    nowagon_sub = 'You don\'t have a cart in this stable',
    nowagon_global_sub = 'You don\'t have a cart',
    takeout = 'Go out',
    etat = 'Etat',
    sellm ='Sale',
    sell = 'Confirmation',
    sell_confirm = 'Confirm the sale of your cart',
    sell_confirm_sub = 'You will sell it for 1/5 of its purchase price',
    buy = 'Buy a trolley',
    price = 'Prix',
    typebuy = 'Type of payment';
    cash = 'Cash payment',
    cash_sub1 = 'Payer',
    cash_sub2 = 'in cash',
    bank = 'Payment via bank',
    bank_sub1 = 'Collect',
    bank_sub2 = 'from your bank account',
    give = 'Donner',

  },

  input = {
    validate = 'To validate',
    namewagon = 'Name your cart',
    namewagon_text = '(Name of your cart)',
    giveid = 'Please indicate the Permanent ID of the recipient (/cid)',
    giveid_text = '(ATTENTION CASE SENSIBLE)',
  },

  state = {
    _out = 'Out',
    _in = 'In',
    _ss = 'Seizure',
    check = 'Verifications, please wait !',
    out = 'This cart is already out !',
    ssheriff = 'This wagon was seized by the sheriffs !',
  },

  other = {
    blips = 'Charron',
    prompt = 'Open the Charron',
  },

}

----------------------------------------------------------------------------------------

Lang = Locale:new({
  phrases = fr,
  warnOnMissing = true
})
