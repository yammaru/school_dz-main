<?php $__env->startSection('content'); ?>
    <div class="container">
        <?php if(!empty(session()->has('msg'))): ?>
            <div class="alert alert-info alert-dismissible fade show mt-30" role="alert">
                <?php echo e(session()->get('msg')); ?>

                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        <?php endif; ?>

        <div class="row login-container">

            <div class="col-12 col-md-6 pl-0">
                <img src="<?php echo e(getPageBackgroundSettings('login')); ?>" class="img-cover" alt="Login">
            </div>
            <div class="col-12 col-md-6">
                <div class="login-card">
                    <h1 class="font-20 font-weight-bold"><?php echo e(trans('auth.login_h1')); ?></h1>

                    <form method="Post" action="/login" class="mt-35">
                        <input type="hidden" name="_token" value="<?php echo e(csrf_token()); ?>">
                        <div class="form-group">
                            <label class="input-label" for="username"><?php echo e(trans('auth.email_or_mobile')); ?>:</label>
                            <input name="username" type="text" class="form-control <?php $__errorArgs = ['username'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is-invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" id="username"
                                   value="<?php echo e(old('username')); ?>" aria-describedby="emailHelp">
                            <?php $__errorArgs = ['username'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                            <div class="invalid-feedback">
                                <?php echo e($message); ?>

                            </div>
                            <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                        </div>

                        <div class="form-group">
                            <label class="input-label" for="password"><?php echo e(trans('auth.password')); ?>:</label>
                            <input name="password" type="password" class="form-control <?php $__errorArgs = ['password'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>  is-invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" id="password" aria-describedby="passwordHelp">

                            <?php $__errorArgs = ['password'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                            <div class="invalid-feedback">
                                <?php echo e($message); ?>

                            </div>
                            <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                        </div>

                        <?php if(!empty(getGeneralSecuritySettings('captcha_for_login'))): ?>
                            <?php echo $__env->make('web.default.includes.captcha_input', \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?>
                        <?php endif; ?>

                        <button type="submit" class="btn btn-primary btn-block mt-20"><?php echo e(trans('auth.login')); ?></button>
                    </form>

                    <?php if(session()->has('login_failed_active_session')): ?>
                        <div class="d-flex align-items-center mt-20 p-15 danger-transparent-alert ">
                            <div class="danger-transparent-alert__icon d-flex align-items-center justify-content-center">
                                <i data-feather="alert-octagon" width="18" height="18" class=""></i>
                            </div>
                            <div class="ml-10">
                                <div class="font-14 font-weight-bold "><?php echo e(session()->get('login_failed_active_session')['title']); ?></div>
                                <div class="font-12 "><?php echo e(session()->get('login_failed_active_session')['msg']); ?></div>
                            </div>
                        </div>
                    <?php endif; ?>

                    

                    <div class="mt-30 text-center">
                        <a href="/forget-password" target="_blank"><?php echo e(trans('auth.forget_your_password')); ?></a>
                    </div>

                    <div class="mt-20 text-center">
                        <span><?php echo e(trans('auth.dont_have_account')); ?></span>
                        <a href="/register" class="text-secondary font-weight-bold"><?php echo e(trans('auth.signup')); ?></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
<?php $__env->stopSection(); ?>

<?php echo $__env->make(getTemplate().'.layouts.app', \Illuminate\Support\Arr::except(get_defined_vars(), ['__data', '__path']))->render(); ?><?php /**PATH C:\laragon\www\school_dz-main\resources\views/web/default/auth/login.blade.php ENDPATH**/ ?>