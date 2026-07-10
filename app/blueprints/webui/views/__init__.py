from flask import render_template, flash, redirect, url_for, request, abort


def index():
    return render_template('content/index.html')