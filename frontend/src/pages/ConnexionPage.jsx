export default function ConnexionPage() {
  const onSubmit = (event) => {
    event.preventDefault();
  };

  return (
    <main className="auth-page">
      <section className="auth-panel">
        <p className="kicker">NotationJV</p>
        <h1>Connexion</h1>
        <p className="subtitle">Connecte-toi pour acceder a ton espace.</p>

        <form className="auth-form" onSubmit={onSubmit}>
          <label htmlFor="email">Adresse e-mail</label>
          <input id="email" name="email" type="email" placeholder="prenom.nom@exemple.com" required />

          <label htmlFor="password">Mot de passe</label>
          <input id="password" name="password" type="password" placeholder="********" required />

          <button type="submit">Se connecter</button>
        </form>

        <p className="helper">Logique d'authentification a brancher ensuite.</p>
      </section>
    </main>
  );
}