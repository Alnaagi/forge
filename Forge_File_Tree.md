# Forge — Starter File Tree

This is a recommended starter file tree with exact filenames.
It is intentionally structured for scale without becoming overbuilt too early.

```text
forge/
  AGENTS.md
  README.md
  analysis_options.yaml
  pubspec.yaml
  .gitignore

  android/
  ios/
  web/
  linux/
  macos/
  windows/
  test/

  assets/
    icons/
    images/
    animations/
    fonts/

  lib/
    main.dart

    bootstrap/
      bootstrap.dart
      env.dart

    app/
      app.dart
      app_shell.dart

      router/
        app_router.dart
        route_names.dart
        route_paths.dart

      theme/
        app_theme.dart
        app_colors.dart
        app_spacing.dart
        app_radius.dart
        app_typography.dart
        theme_mode_controller.dart

      core/
        constants/
          app_constants.dart
          db_constants.dart
          health_constants.dart
          nutrition_constants.dart
          workout_constants.dart

        errors/
          app_exception.dart
          failure.dart
          result.dart

        extensions/
          date_time_extensions.dart
          num_extensions.dart
          string_extensions.dart

        services/
          notification_service.dart
          permission_service.dart
          clock_service.dart
          uuid_service.dart

        utils/
          date_utils.dart
          debounce.dart
          formatter_utils.dart

        widgets/
          app_scaffold.dart
          app_bottom_nav.dart
          empty_state_view.dart
          error_state_view.dart
          loading_view.dart
          section_header.dart

    shared/
      enums/
        app_theme_mode.dart
        goal_type.dart
        meal_type.dart
        reminder_type.dart
        set_type.dart
        sex_optional.dart
        insight_category.dart
        insight_severity.dart
        insight_status.dart
        sync_source.dart
        unit_kind.dart
        weight_unit.dart
        body_measure_unit.dart
        distance_unit.dart
        structure_type.dart

      value_objects/
        weight_value.dart
        measurement_value.dart
        percentage_value.dart
        date_range.dart
        macro_target.dart

      unit_system/
        unit_converter.dart
        unit_formatter.dart
        canonical_unit_rules.dart

      charts/
        chart_time_range.dart
        chart_metric.dart

      animations/
        animation_tokens.dart

    domain/
      entities/
        user_profile.dart
        goal.dart
        exercise.dart
        workout_template.dart
        workout_template_item.dart
        workout_session.dart
        workout_exercise_entry.dart
        set_entry.dart
        body_log.dart
        food.dart
        meal_entry.dart
        hydration_log.dart
        reminder.dart
        health_sync_record.dart
        insight.dart
        app_setting.dart

      repositories/
        auth_repository.dart
        settings_repository.dart
        workout_repository.dart
        exercise_repository.dart
        nutrition_repository.dart
        body_metrics_repository.dart
        analytics_repository.dart
        insight_repository.dart
        reminder_repository.dart
        health_sync_repository.dart
        sync_repository.dart

      services/
        e1rm_service.dart
        volume_service.dart
        pr_detection_service.dart
        relative_strength_service.dart
        goal_priority_service.dart
        plateau_detection_service.dart
        deload_recommendation_service.dart
        muscle_balance_service.dart
        nutrition_resolution_service.dart

      use_cases/
        workouts/
          start_workout_session.dart
          complete_workout_session.dart
          log_set_entry.dart
          get_workout_history.dart
        nutrition/
          search_foods.dart
          add_custom_food.dart
          log_meal.dart
        body/
          log_body_weight.dart
          get_body_progress.dart
        analytics/
          get_home_dashboard.dart
          get_strength_dashboard.dart
          get_nutrition_dashboard.dart
        insights/
          generate_insights.dart
          dismiss_insight.dart
        settings/
          update_unit_preferences.dart
          update_theme_mode.dart

    data/
      local/
        db/
          app_database.dart
          app_database.g.dart

          converters/
            date_time_converter.dart
            json_map_converter.dart
            list_string_converter.dart

          tables/
            users_table.dart
            goals_table.dart
            exercises_table.dart
            workout_templates_table.dart
            workout_template_items_table.dart
            workout_sessions_table.dart
            workout_exercise_entries_table.dart
            set_entries_table.dart
            body_logs_table.dart
            foods_table.dart
            meal_entries_table.dart
            hydration_logs_table.dart
            reminders_table.dart
            health_sync_records_table.dart
            insights_table.dart
            app_settings_table.dart

          daos/
            settings_dao.dart
            exercise_dao.dart
            workout_dao.dart
            nutrition_dao.dart
            body_metrics_dao.dart
            reminder_dao.dart
            insight_dao.dart
            health_sync_dao.dart
            analytics_dao.dart

          migrations/
            migration_v1.dart
            migration_v2.dart

          seeds/
            built_in_exercises_seed.dart

      remote/
        clients/
          nutrition_api_client.dart
          barcode_api_client.dart

        dto/
          food_search_result_dto.dart
          barcode_lookup_result_dto.dart

        mappers/
          food_dto_mapper.dart
          barcode_dto_mapper.dart

      repositories/
        auth_repository_impl.dart
        settings_repository_impl.dart
        workout_repository_impl.dart
        exercise_repository_impl.dart
        nutrition_repository_impl.dart
        body_metrics_repository_impl.dart
        analytics_repository_impl.dart
        insight_repository_impl.dart
        reminder_repository_impl.dart
        health_sync_repository_impl.dart
        sync_repository_impl.dart

    features/
      onboarding/
        README.md
        presentation/
          screens/
            onboarding_screen.dart
            permissions_setup_screen.dart
          controllers/
            onboarding_controller.dart
          widgets/
            onboarding_page_view.dart

      settings/
        README.md
        presentation/
          screens/
            settings_screen.dart
            unit_preferences_screen.dart
            appearance_screen.dart
            backup_sync_screen.dart
          controllers/
            settings_controller.dart
          widgets/
            settings_tile.dart

      dashboard/
        README.md
        presentation/
          screens/
            home_dashboard_screen.dart
          controllers/
            home_dashboard_controller.dart
          widgets/
            advice_banner_card.dart
            daily_macro_card.dart
            next_workout_card.dart
            bodyweight_trend_card.dart
            streak_card.dart
            quick_actions_row.dart

      workouts/
        README.md
        presentation/
          screens/
            workouts_home_screen.dart
            live_workout_screen.dart
            workout_history_screen.dart
            workout_session_detail_screen.dart
          controllers/
            live_workout_controller.dart
            workout_history_controller.dart
          widgets/
            set_logger_row.dart
            rest_timer_card.dart
            repeat_last_set_button.dart
            session_summary_sheet.dart

      exercises/
        README.md
        presentation/
          screens/
            exercise_library_screen.dart
            exercise_detail_screen.dart
            create_custom_exercise_screen.dart
          controllers/
            exercise_library_controller.dart
          widgets/
            exercise_list_item.dart

      templates/
        README.md
        presentation/
          screens/
            template_list_screen.dart
            template_builder_screen.dart
          controllers/
            template_builder_controller.dart
          widgets/
            template_exercise_tile.dart

      nutrition/
        README.md
        presentation/
          screens/
            nutrition_home_screen.dart
            food_search_screen.dart
            meal_log_screen.dart
            saved_meals_screen.dart
            hydration_screen.dart
          controllers/
            nutrition_controller.dart
            food_search_controller.dart
          widgets/
            food_result_tile.dart
            macro_progress_card.dart
            hydration_quick_add_row.dart

      barcode/
        README.md
        presentation/
          screens/
            barcode_scan_screen.dart
            barcode_match_result_screen.dart
            create_food_for_barcode_screen.dart
          controllers/
            barcode_controller.dart

      body_metrics/
        README.md
        presentation/
          screens/
            body_progress_screen.dart
            add_body_log_screen.dart
          controllers/
            body_progress_controller.dart
          widgets/
            bodyweight_chart_card.dart
            measurement_summary_card.dart

      goals/
        README.md
        presentation/
          screens/
            goals_screen.dart
            goal_setup_screen.dart
          controllers/
            goal_controller.dart
          widgets/
            goal_type_card.dart
            target_progress_card.dart

      analytics/
        README.md
        presentation/
          screens/
            analytics_home_screen.dart
            strength_analytics_screen.dart
            nutrition_analytics_screen.dart
            consistency_analytics_screen.dart
          controllers/
            analytics_controller.dart
          widgets/
            chart_card.dart
            time_range_switcher.dart
            unit_switcher.dart
            period_compare_card.dart

      insights/
        README.md
        presentation/
          screens/
            insights_archive_screen.dart
            insight_detail_screen.dart
          controllers/
            insights_controller.dart
          widgets/
            insight_list_tile.dart
            evidence_block.dart

      reminders/
        README.md
        presentation/
          screens/
            reminders_screen.dart
            create_reminder_screen.dart
          controllers/
            reminder_controller.dart
          widgets/
            reminder_tile.dart

      health_sync/
        README.md
        presentation/
          screens/
            health_sync_settings_screen.dart
          controllers/
            health_sync_controller.dart
          widgets/
            health_permission_card.dart
            health_summary_card.dart

      reports/
        README.md
        presentation/
          screens/
            reports_screen.dart
          controllers/
            reports_controller.dart

  integration_test/
    app_test.dart

  test/
    shared/
      unit_system/
        unit_converter_test.dart

    domain/
      services/
        e1rm_service_test.dart
        volume_service_test.dart
        pr_detection_service_test.dart
        relative_strength_service_test.dart
        plateau_detection_service_test.dart
        deload_recommendation_service_test.dart
        nutrition_resolution_service_test.dart

    features/
      workouts/
        live_workout_controller_test.dart
      nutrition/
        food_search_controller_test.dart
      analytics/
        analytics_controller_test.dart
      insights/
        insights_controller_test.dart
```
