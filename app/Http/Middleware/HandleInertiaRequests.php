<?php

namespace App\Http\Middleware;

use Illuminate\Http\Request;
use Inertia\Middleware;

class HandleInertiaRequests extends Middleware
{
    /**
     * The root template that's loaded on the first page visit.
     *
     * @see https://inertiajs.com/server-side-setup#root-template
     *
     * @var string
     */
    protected $rootView = 'app';

    /**
     * Determines the current asset version.
     *
     * @see https://inertiajs.com/asset-versioning
     */
    public function version(Request $request): ?string
    {
        return parent::version($request);
    }

    /**
     * Define the props that are shared by default.
     *
     * @see https://inertiajs.com/shared-data
     *
     * @return array<string, mixed>
     */
    public function share(Request $request): array
    {
        return array_merge(parent::share($request), [
            //
            'auth.user.user' => fn() => $request->user()
                ? $request->user()->only(['id', 'name', 'email'])
                : null,
            'auth.user.roles' => fn() => $request->user()
                ? $request->user()->getRoleNames()
                : null,
            'auth.user.permissions' => fn() => $request->user()
                ? $request->user()->getAllPermissions()->pluck('name')
                : null,
            'auth.user.empresa' => fn() => $request->user()
                ? $request->user()->empresa
                : null,
            'flash' => [
                'error' => fn() => $request->session()->get('error'),
                'success' => fn() => $request->session()->get('success'),
            ],
        ]);
    }
}
