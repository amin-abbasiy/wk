import { Controller } from "@hotwired/stimulus"
import "chartkick"
import "Chart.bundle"

export default class extends Controller {
  static values = { data: Array, colors: Array }

  connect() {
    this.motionPreference = window.matchMedia("(prefers-reduced-motion: reduce)")
    this.render = this.render.bind(this)
    this.motionPreference.addEventListener("change", this.render)
    this.render()
  }

  disconnect() {
    this.motionPreference.removeEventListener("change", this.render)
    this.chart?.destroy()
  }

  render() {
    this.chart?.destroy()
    this.chart = new window.Chartkick.BarChart(this.element, this.dataValue, {
      adapter: "chartjs",
      legend: false,
      xtitle: "Count",
      ytitle: "Status",
      min: 0,
      dataset: {
        backgroundColor: this.colorsValue,
        hoverBackgroundColor: this.colorsValue,
        borderWidth: 0,
        borderRadius: 6,
        borderSkipped: false,
        maxBarThickness: 24
      },
      library: {
        responsive: true,
        maintainAspectRatio: false,
        animation: this.motionPreference.matches ? false : {
          duration: 450,
          easing: "easeOutQuart"
        },
        interaction: { mode: "index", axis: "y", intersect: false },
        plugins: {
          tooltip: {
            backgroundColor: "#334155",
            cornerRadius: 8,
            padding: 12,
            callbacks: {
              label: (context) => {
                const count = context.parsed.x
                return `${count} ${count === 1 ? "application" : "applications"}`
              }
            }
          }
        },
        scales: {
          x: {
            beginAtZero: true,
            suggestedMax: 1,
            border: { display: false },
            grid: { color: "#EEF2F6", drawTicks: false },
            ticks: { precision: 0, color: "#64748B", padding: 8 }
          },
          y: {
            border: { display: false },
            grid: { display: false },
            ticks: {
              autoSkip: false,
              color: "#475569",
              font: { size: 12 },
              padding: 8,
              callback: function(value) {
                // Wrap long status names so they leave room for bars on mobile.
                return this.getLabelForValue(value).split(" ").reduce((lines, word) => {
                  const last = lines.length - 1
                  if (lines[last] && `${lines[last]} ${word}`.length <= 20) {
                    lines[last] += ` ${word}`
                  } else {
                    lines.push(word)
                  }
                  return lines
                }, [])
              }
            }
          }
        }
      }
    })
  }
}
