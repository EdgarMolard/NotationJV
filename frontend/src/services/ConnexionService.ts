type LoginResponse = {
    message: string;
    error?: string;
};

export type CurrentUser = {
    userId: string;
    username: string;
    isAdmin: boolean;
};

export async function login(username: string, password: string): Promise<LoginResponse> {
    const apiBaseUrl = "http://localhost:3000";
    const response = await fetch(`${apiBaseUrl}/api/login`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        credentials: "include",
        body: JSON.stringify({ username, password })
    });

    const data = (await response.json()) as LoginResponse;

    if (!response.ok) {
        throw new Error(data.error ?? "Erreur lors de la connexion.");
    }

    return data;
}

export async function getCurrentUser(): Promise<CurrentUser> {
    const apiBaseUrl = "http://localhost:3000";
    const response = await fetch(`${apiBaseUrl}/api/me`, {
        method: "GET",
        credentials: "include"
    });

    const data = (await response.json()) as CurrentUser & { error?: string };

    if (!response.ok) {
        throw new Error(data.error ?? "Impossible de recuperer l'utilisateur courant.");
    }

    return {
        userId: data.userId,
        username: data.username,
        isAdmin: data.isAdmin,
    };
}

export async function logout(): Promise<void> {
    const apiBaseUrl = "http://localhost:3000";
    const response = await fetch(`${apiBaseUrl}/api/logout`, {
        method: "POST",
        credentials: "include"
    });

    if (!response.ok) {
        throw new Error("Erreur lors de la deconnexion.");
    }
}
