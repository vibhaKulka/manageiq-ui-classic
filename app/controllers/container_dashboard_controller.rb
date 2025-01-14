class ContainerDashboardController < ApplicationController
  extend ActiveSupport::Concern

  include Mixins::GenericSessionMixin
  include Mixins::BreadcrumbsMixin

  before_action :check_privileges
  before_action :get_session_data
  after_action :cleanup_action
  after_action :set_session_data

  def data
    assert_privileges("container_dashboard_view")

    render :json => {:data => collect_data(params[:id])}
  end

  def heatmaps_data
    assert_privileges("container_dashboard_view")

    render :json => {:data => collect_heatmaps_data(params[:id])}
  end

  def ems_utilization_data
    assert_privileges("container_dashboard_view")

    render :json => {:data => collect_ems_utilization_data(params[:id])}
  end

  def network_metrics_data
    assert_privileges("container_dashboard_view")

    render :json => {:data => collect_network_metrics_data(params[:id])}
  end

  def pod_metrics_data
    assert_privileges("container_dashboard_view")

    render :json => {:data => collect_pod_metrics_data(params[:id])}
  end

  def image_metrics_data
    assert_privileges("container_dashboard_view")

    render :json => {:data => collect_image_metrics_data(params[:id])}
  end

  def refresh_status_data
    assert_privileges("container_dashboard_view")

    render :json => {:data => collect_refresh_status_data(params[:id])}
  end

  def project_data
    assert_privileges("container_dashboard_view")

    render :json => {:data => collect_project_data(params[:id]) }
  end

  def title
    _("Container Dashboard")
  end

  def self.session_key_prefix
    "container_dashboard"
  end

  def show
    assert_privileges('container_dashboard_view')
  end

  private

  def get_session_data
    super
  end

  def collect_data(provider_id)
    ContainerDashboardService.new(provider_id, self).all_data
  end

  def collect_heatmaps_data(provider_id)
    ContainerDashboardService.new(provider_id, self).all_heatmaps_data
  end

  def collect_ems_utilization_data(provider_id)
    ContainerDashboardService.new(provider_id, self).ems_utilization_data
  end

  def collect_network_metrics_data(provider_id)
    ContainerDashboardService.new(provider_id, self).network_metrics_data
  end

  def collect_pod_metrics_data(provider_id)
    ContainerDashboardService.new(provider_id, self).pod_metrics_data
  end

  def collect_image_metrics_data(provider_id)
    ContainerDashboardService.new(provider_id, self).image_metrics_data
  end

  def collect_refresh_status_data(provider_id)
    ContainerDashboardService.new(provider_id, self).refresh_status_data
  end

  def collect_project_data(project_id)
    ContainerProjectDashboardService.new(project_id, self).all_data
  end

  def breadcrumbs_options
    {
      :breadcrumbs => [
        {:title => _("Compute")},
        {:title => _("Containers")},
        {:title => _("Overview"), :url => controller_url},
      ],
    }
  end

  menu_section :cnt
end
